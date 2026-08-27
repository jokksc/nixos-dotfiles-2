{ lib, config, pkgs, ...}:
  
{
  virtualisation.podman.enable = true;
  # virtualisation.docker.enable = true;
  
  environment.systemPackages = with pkgs; [
    distrobox
    podman
  ];

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
      # ovmf.enable = true;
      # ovmf.packages = [ pkgs.OVMFFull.fd ];
    };
  };

  programs.virt-manager.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  boot.kernelModules = [ "kvm-intel" ];
}