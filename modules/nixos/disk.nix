{
  disko.devices = {
    disk = {
      main = {
        device = "/dev/nvme0n1";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              end = "5120M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            root = {
size = "100%";
content = {
type = "filesystem";
format = "ext4";
mountpoint = "/";
};
            };
          };
        };
      };
    };
  };
}
