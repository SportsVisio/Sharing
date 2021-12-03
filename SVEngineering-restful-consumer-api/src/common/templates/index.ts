import { readFileSync } from "fs";
import { render } from "mustache";

// partials objects have dynamic attribute names
interface IGenericPartials {
  [x: string]: any;
}

export const TemplateFactory = <T>(file: string, data: T, partials?: IGenericPartials): string => {
  const content = readFileSync(`${__dirname}/${file}.mustache`);
  if (!content) throw new Error("Template not found.");

  return render(content.toString(), data, partials);
};

export const EmailTemplateFactory = <T>(file: string, data: T, previewText?: string): string => {
  const content = TemplateFactory(file, data);
  return TemplateFactory("email-base", {
    previewText 
  }, {
    content
  });
};