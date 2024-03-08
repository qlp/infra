sepolia:
	nixos-rebuild switch --no-build-nix --build-host root@159.69.146.56 --target-host root@159.69.146.56 --use-remote-sudo --use-substitutes --flake ./#sepolia

db:
	nixos-rebuild switch --no-build-nix --build-host root@91.107.236.65 --target-host root@91.107.236.65 --use-remote-sudo --use-substitutes --flake ./#db

miasma:
	nixos-rebuild switch --no-build-nix --build-host root@49.13.152.216 --target-host root@49.13.152.216 --use-remote-sudo --use-substitutes --flake ./#miasma

testnet:
	nixos-rebuild switch --no-build-nix --build-host root@167.235.25.11 --target-host root@167.235.25.11 --use-remote-sudo --use-substitutes --flake ./#testnet


psql:
	psql "postgres://union:foofdssdfsdfsgxfgstdfsrtg@91.107.236.65:5432/union"