function report = check_installation()
%CHECK_INSTALLATION Verify dependencies and bundled training data.

root = setup_project();
report = struct();
report.matlabAvailable = ~isempty(version);
report.yalmipAvailable = exist("sdpvar", "file") == 2 && exist("optimize", "file") == 2;
report.gurobiAvailable = exist("gurobi", "file") == 2;
requiredFiles = {
    fullfile(root, "data_set", "dataset_cement.mat")
    fullfile(root, "data_set", "dataset_steelpowder.mat")
    fullfile(root, "data_set", "dataset_steelmaking.mat")
    fullfile(root, "main_training.m")
    fullfile(root, "model_training.m")
    };
report.filesAvailable = all(cellfun(@isfile, requiredFiles));
report.ok = report.matlabAvailable && report.yalmipAvailable && ...
    report.gurobiAvailable && report.filesAvailable;

fprintf("MATLAB: %s\n", statusText(report.matlabAvailable));
fprintf("YALMIP: %s\n", statusText(report.yalmipAvailable));
fprintf("Gurobi: %s\n", statusText(report.gurobiAvailable));
fprintf("Bundled datasets and scripts: %s\n", statusText(report.filesAvailable));

if ~report.yalmipAvailable
    fprintf("  Install YALMIP and add it to the MATLAB path.\n");
end
if ~report.gurobiAvailable
    fprintf("  Install Gurobi, its MATLAB interface, and configure a license.\n");
end
if ~report.filesAvailable
    fprintf("  One or more bundled datasets or scripts are missing.\n");
end
if ~report.ok
    error("D3R:InstallationIncomplete", ...
        "Installation is incomplete. Resolve the messages above before training.");
end
end

function text = statusText(value)
if value
    text = "OK";
else
    text = "MISSING";
end
end
