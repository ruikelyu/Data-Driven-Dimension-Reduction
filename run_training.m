function results = run_training(varargin)
%RUN_TRAINING Train the ALF models from any MATLAB current folder.
%
% Name-value options:
%   "Solver"     Solver name (default "gurobi")
%   "TimeLimit"  Per-iteration time limit in seconds (default 120)
%   "MaxIterations" Maximum training iterations (default 40)

root = setup_project();
check_installation();

p = inputParser;
addParameter(p, "Solver", "gurobi", @(x) ischar(x) || isstring(x));
addParameter(p, "TimeLimit", 120, @(x) isnumeric(x) && isscalar(x) && x > 0);
addParameter(p, "MaxIterations", 40, @(x) isnumeric(x) && isscalar(x) && x >= 0);
parse(p, varargin{:});

DATA_ROOT = root;
SOLVER_NAME = char(p.Results.Solver);
TIME_LIMIT = p.Results.TimeLimit;
MAX_ITERATIONS = p.Results.MaxIterations;

run(fullfile(root, "main_training.m"));
results = struct("root", root, "solver", SOLVER_NAME, ...
    "timeLimit", TIME_LIMIT, "maxIterations", MAX_ITERATIONS);
end
