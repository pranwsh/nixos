{...}: {
  programs.nvf.settings = {
    vim.visuals.indent-blankline = {
      enable = true;
      setupOpts = {
        # ... your existing indent settings ...
        scope = {
          enabled = true;
          # This helps the plugin find the scope in "flatter" languages like Nix
          include = {
            node_type = {
              # General nodes
              "*" = ["arguments" "parameters" "list" "table"];
              # Nix specific nodes that define scopes
              nix = [
                "binding_set"
                "attrset"
                "let_expression"
                "inherited_attrs"
                "parenthesized_expression"
              ];
              cpp = ["compound_statement" "function_definition"];
            };
          };
        };
      };
    };
  };
}
