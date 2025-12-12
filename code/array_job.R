# Define the parameters
Ns <- seq(from = 10, to = 100, by = 10)
ps <- seq(from = 0.1, to = 0.9, by = 0.1)

# Create the scenarios data frame
scenarios <- expand.grid(N = Ns, p = ps)

# Define the simulation function
run_simulation <- function(N, p, savepath = NULL) {
    data <- rbinom(N, size = 1, prob = p)
    out <- data.frame(
        "N" = N,
        "p" = p,
        "mean" = mean(data),
        "MLE" = sum(data) / N,
        "var" = var(data)
    )
    if (!is.null(savepath)) {
        output_file <- file.path(
            savepath,
            paste0("results_N_", N, "_p_", gsub("\\.", "", as.character(p)), ".csv")
        )
        write.csv(out, file = output_file, row.names = FALSE)
    }
}

# Get the task ID from the SLURM environment variable
slurm_task_id <- as.numeric(Sys.getenv("SLURM_ARRAY_TASK_ID", "1"))

# Split the scenarios into chunks based on the task ID
num_tasks <- as.numeric(Sys.getenv("SLURM_ARRAY_TASK_COUNT", "1"))
chunk_size <- ceiling(nrow(scenarios) / num_tasks)
start_index <- (slurm_task_id - 1) * chunk_size + 1
end_index <- min(slurm_task_id * chunk_size, nrow(scenarios))

# Subset the scenarios for this task
scenarios_subset <- scenarios[start_index:end_index, ]

# Define the output directory
output_dir <- file.path("results", "array_job")
if (!dir.exists(output_dir)) dir.create(output_dir, recursive = TRUE)

# Run the simulations for the subset
results <- lapply(
    1:nrow(scenarios_subset),
    function(i) {
        N <- scenarios_subset$N[i]
        p <- scenarios_subset$p[i]
        run_simulation(N, p, output_dir)
    }
)