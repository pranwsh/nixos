{ pkgs, ... }:

let
  # Helper function to reduce repetition
  mkModel =
    {
      repo,
      file,
      sha256,
      name ? file,
    }:
    {
      name = name;
      path = pkgs.fetchurl {
        url = "https://huggingface.co/${repo}/resolve/main/${file}";
        sha256 = sha256;
        name = file;
      };
    };

in
{
  bonsai-27b = mkModel {
    repo = "prism-ml/Bonsai-27B-gguf";
    file = "Bonsai-27B-Q1_0.gguf";
    sha256 = "sha256-F++ELkdFDK646qPr+7q10vIni2K3m+EHmF+2mi+BmqA=";
  };

  gemma4-e4b-uncensored = mkModel {
    repo = "HauhauCS/Gemma-4-E4B-Uncensored-HauhauCS-Aggressive";
    file = "Gemma-4-E4B-Uncensored-HauhauCS-Aggressive-Q5_K_P.gguf";
    sha256 = "sha256-vhiZXcVUtlCSVPOP19bzGTeTCRdQBypXr0e8olJbFSE=";
  };

  ling3-tiny-int4 = mkModel {
    repo = "bloomer010/Ling-3.0-tiny-GGUF";
    file = "Ling-3.0-tiny-Q4_K_M.gguf";
    sha256 = "0s4fkjvm34z2mn7152bdaybg23vi6l89mdyjxynx8ym0q7kwqhlq";
  };
}
