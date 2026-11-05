class RenameDanangbassmanArtistSlugToStefan < ActiveRecord::Migration[8.1]
  def up
    execute "UPDATE artists SET slug = 'stefan' WHERE slug = 'danangbassman'"
    execute <<~SQL.squish
      UPDATE news_translations
      SET body_markdown = REPLACE(body_markdown, '/artists/danangbassman', '/artists/stefan')
      WHERE body_markdown LIKE '%/artists/danangbassman%'
    SQL
  end

  def down
    execute <<~SQL.squish
      UPDATE news_translations
      SET body_markdown = REPLACE(body_markdown, '/artists/stefan', '/artists/danangbassman')
      WHERE body_markdown LIKE '%/artists/stefan%'
    SQL
    execute "UPDATE artists SET slug = 'danangbassman' WHERE slug = 'stefan'"
  end
end
