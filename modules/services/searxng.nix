{ ... }:
{
  services.searx = {
    enable = true;
    redisCreateLocally = true;

    settings = {
      server = {
        bind_address = "127.0.0.1";
        port = 8888;
        secret_key = "123";
        limiter = true;
        image_proxy = true;
        method = "POST";
        public_instance = false;
      };

      general = {
        instance_name = "SearXNG";
        enable_metrics = false;
      };

      search = {
        formats = [ "html" "json" ];
        autocomplete = "google";
      };
    };
  };
}
