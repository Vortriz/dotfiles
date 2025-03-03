{
    pkgs,
    ...
}: {
	programs.yazi = {
		enable = true;

		shellWrapperName = "y";

		settings = {
			manager = {
				show_hidden = true;
			};
			preview = {
				max_width = 1000;
				max_height = 1000;
			};
		};
	};

    stylix.targets.yazi.enable = true;
}