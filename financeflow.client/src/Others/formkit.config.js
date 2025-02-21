import { en } from "@formkit/i18n";
import { genesisIcons } from "@formkit/icons";
import { defaultConfig } from "@formkit/vue";

const config = defaultConfig({
  theme: 'genesis',
  locales: { en },
  locale: "en",
  icons: { ...genesisIcons },
  config: {
    classes: {
      text: {
        input:
          "py-3 px-4 block w-full border-gray-500 rounded text-sm focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none bg-gray-300 dark:border-gray-500 dark:text-neutral-700 dark:placeholder-neutral-500 dark:focus:ring-neutral-600",
      },
    },
  },
});

export default config;
