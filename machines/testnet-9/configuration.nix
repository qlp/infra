{ ... }: {
  imports = [
    ./hardware-configuration.nix
    ./networking.nix # generated at runtime by nixos-infect
    
  ];

  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = true;
  networking.hostName = "testnet-9";
  networking.domain = "";
  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keys = [''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB4rUA+CKIC1RK6NVxMaPkYIABhs5zL2Hwdxu4HSrpOH'' ''ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQChF2EKwVuOlKL4Vbd0TNsdMdoTp1y5Fify/ga/o1fj1hADUfk1f6I7KYdVxxhmWINZ1ZClbOja81wwv03azw70JHSQX3eh7fH+hpmcKSp/CuuSmZZi9Vm+eb06NqYM7QKfVSTRVLXC4W1MMAn7MHp4RA3JVJva3ME8XiDPReftzOXyNolq6e5AON1+/o2CspsqPwVM//60fkz9ougiDQIro4HLHqdqfisHrdHIzex8KD7sIoqjNIiEt+cdAExf3zo5pFQZKmsvuWI534dA++tWCJuPATCbqP7MT0K+9pb9MpKHyqoB8DpdCoU6y6/wP60Ef0s8UfljbFP45+doT6yjNqWtPMiEBh8ee8DsPJHZu9v085jHk1SD/mE6lQt6Du61UUNrZHBsTFGcRz9+k4l55dsBPF7i1UCKFu4jdIU57O4yCbnIenEyMvNFitgaJ2ul2ryHorI8CmlwHQyUhtUZMAMyY0TwLR5DXDwTrGaTXaNpichli5kbk1x05ATgvRc='' 
  ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB4rUA+CKIC1RK6NVxMaPkYIABhs5zL2Hwdxu4HSrpOH jurriaan@pruijs.nl''];
  system.stateVersion = "23.11";
}