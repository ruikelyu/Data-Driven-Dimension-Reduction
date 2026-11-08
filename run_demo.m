function results = run_demo()
%RUN_DEMO Run a short root-level training smoke test.

results = run_training("TimeLimit", 10, "MaxIterations", 1);
end
