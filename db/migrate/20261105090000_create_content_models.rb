class CreateContentModels < ActiveRecord::Migration[8.1]
  def change
    create_table :artists do |t|
      t.string :slug, null: false
      t.string :name, null: false
      t.json :role, null: false, default: {}
      t.json :location, null: false, default: {}
      t.json :tagline, null: false, default: {}
      t.json :bio, null: false, default: {}
      t.json :links, null: false, default: []
      t.json :sources, null: false, default: []
      t.json :remote_media, null: false, default: []
      t.boolean :featured, null: false, default: false
      t.timestamps
    end
    add_index :artists, :slug, unique: true

    create_table :promoters do |t|
      t.string :slug, null: false
      t.json :name, null: false, default: {}
      t.json :description, null: false, default: {}
      t.json :links, null: false, default: []
      t.timestamps
    end
    add_index :promoters, :slug, unique: true

    create_table :venues do |t|
      t.string :slug, null: false
      t.json :name, null: false, default: {}
      t.json :location, null: false, default: {}
      t.json :links, null: false, default: []
      t.timestamps
    end
    add_index :venues, :slug, unique: true

    create_table :events do |t|
      t.string :slug, null: false
      t.json :name, null: false, default: {}
      t.json :location, null: false, default: {}
      t.json :bio, null: false, default: {}
      t.json :kind, null: false, default: {}
      t.datetime :starts_at
      t.string :timezone, null: false, default: "Asia/Tokyo"
      t.boolean :all_day, null: false, default: false
      t.json :description, null: false, default: {}
      t.json :work, null: false, default: {}
      t.json :links, null: false, default: []
      t.references :venue, foreign_key: true
      t.timestamps
    end
    add_index :events, :slug, unique: true
    add_index :events, :starts_at

    create_table :event_artists do |t|
      t.references :event, null: false, foreign_key: true
      t.references :artist, null: false, foreign_key: true
      t.string :role
      t.integer :position, null: false, default: 0
      t.timestamps
    end
    add_index :event_artists, %i[event_id artist_id], unique: true

    create_table :event_promoters do |t|
      t.references :event, null: false, foreign_key: true
      t.references :promoter, null: false, foreign_key: true
      t.string :role
      t.integer :position, null: false, default: 0
      t.timestamps
    end
    add_index :event_promoters, %i[event_id promoter_id], unique: true

    create_table :news_articles do |t|
      t.string :slug, null: false
      t.string :category, null: false
      t.date :published_at, null: false
      t.timestamps
    end
    add_index :news_articles, :slug, unique: true
    add_index :news_articles, :published_at

    create_table :news_translations do |t|
      t.references :news_article, null: false, foreign_key: true
      t.string :locale, null: false
      t.string :title, null: false
      t.text :description, null: false, default: ""
      t.text :body_markdown, null: false, default: ""
      t.timestamps
    end
    add_index :news_translations, %i[news_article_id locale], unique: true

    create_table :news_artists do |t|
      t.references :news_article, null: false, foreign_key: true
      t.references :artist, null: false, foreign_key: true
      t.timestamps
    end
    add_index :news_artists, %i[news_article_id artist_id], unique: true

    create_table :news_events do |t|
      t.references :news_article, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true
      t.timestamps
    end
    add_index :news_events, %i[news_article_id event_id], unique: true

    create_table :news_promoters do |t|
      t.references :news_article, null: false, foreign_key: true
      t.references :promoter, null: false, foreign_key: true
      t.timestamps
    end
    add_index :news_promoters, %i[news_article_id promoter_id], unique: true

    create_table :news_embeds do |t|
      t.references :news_article, null: false, foreign_key: true
      t.string :title, null: false
      t.string :source_url, null: false
      t.string :provider, null: false
      t.integer :height, null: false, default: 400
      t.integer :position, null: false, default: 0
      t.timestamps
    end
    add_index :news_embeds, %i[news_article_id position]
  end
end
