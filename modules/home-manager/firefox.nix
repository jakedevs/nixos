{ lib, inputs, pkgs, ... }: {
  programs.firefox = {

    enable = true;
    package = inputs.firefox.packages.${pkgs.system}.firefox-nightly-bin;

    profiles.default = {
      name = "main";

      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
        bitwarden
        fastforwardteam
        youtube-recommended-videos
      ];

      settings = {
        "browser.tabsinTitlebar" = "0";
        "identity.fxaccounts.enabled" = false;
        "gfx.canvas.accelerated.cache-items" = 4096;
        "gfx.canvas.accelerated.cache-size" = 512;
        "gfx.content.skia-font-cache-size" = 20;
        "gfx.webrender.all" = true;
        "gfx.webrender.precache-shaders" = true;
        "gfx.webrender.compositor" = true;
        "gfx.webrender.compositor.force-enabled" = true;
        "browser.cache.memory.capacity" = -1;
        "browser.cache.memory.max_entry_size" = 10240;
        "media.memory_cache_max_size" = 65536;
        "media.cache_readahead_limit" = 7200;
        "media.cache_resume_threshold" = 3600;
        "image.mem.decode_bytes_at_a_time" = 32768;
				"network.http.max-connections" = 1800;
				"network.http.max-persistent-connections-per-server" = 10;
				"network.http.max-urgent-start-excessive-connections-per-host" = 5;
				"network.http.pacing.requests.enabled" = false;
				"network.dnsCacheExpiration" = 3600;
				"network.dns.max_high_priority_threads" = 8;
				"network.ssl_tokens_cache_capacity" = 10240;

				#NIGHTLY ONLY
				"layout.css.grid-template-masonry-value.enabled" = true;
				"dom.enable_web_task_scheduling" = true;
				"layout.css.has-selector.enabled" = true;
      };
    };
  };
}
