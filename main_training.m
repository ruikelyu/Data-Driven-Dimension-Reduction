% Train the ALF model on three different datasets
if ~exist("DATA_ROOT", "var")
    DATA_ROOT = fileparts(mfilename("fullpath"));
end
if ~exist("SOLVER_NAME", "var")
    SOLVER_NAME = "gurobi";
end
if ~exist("TIME_LIMIT", "var")
    TIME_LIMIT = 120;
end
if ~exist("MAX_ITERATIONS", "var")
    MAX_ITERATIONS = 40;
end
data_set_names = ["cement", "steelpowder", "steelmaking"];
for name_idx = 1:3
    data_set_name = data_set_names(name_idx);
    model_training;
end
