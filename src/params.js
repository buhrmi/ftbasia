import { defineParams } from "@sveltejs/kit/params";
import { parseLocale } from "./params/locale.js";

export const params = defineParams({ locale: parseLocale });
