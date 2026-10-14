-- langs/java.lua
-- Drop a file like this into langs/ for any language you want to add.

return {
  lsp = {
    servers = {
      -- Binary comes from `jdt-language-server` (nixpkgs has no `jdtls` attr).
      -- lspconfig already picks the root from pom.xml/gradlew/settings.gradle.
      jdtls = {
        settings = {
          java = {
            configuration = {
              updateBuildConfiguration = "automatic",
            },
            errors = {
              incompleteClasspath = "error",
            },
          },
        },
      },
    },
  },

  lint = {
    linters_by_ft = {
      -- Uses checkstyle's bundled /google_checks.xml, so no config file needed.
      java = { "checkstyle" },
    },
  },
}
