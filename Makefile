deploy-testnet-9:
	 nixos-rebuild switch --build-host root@23.88.101.17 --target-host root@23.88.101.17 --use-substitutes --fast --flake ./#testnet-9
ssh-testnet-9:
	ssh root@23.88.101.17
