library(parallel)
library(parallelly)

Ns <- seq(from = 10, to = 100, by = 10)
ps <- seq(from = 0.1, to = 0.9, by = 0.1)

scenarios <- expand.grid(N = Ns, p = ps)

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

output_dir <- file.path("results", "parallel_within")
if (!dir.exists(output_dir)) dir.create(output_dir, recursive = TRUE)

results <- mclapply(
    1:nrow(scenarios),
    function(i) {
        N <- scenarios$N[i]
        p <- scenarios$p[i]
        run_simulation(i, N, p, output_dir)
    },
    mc.cores = availableCores() - 1
)
