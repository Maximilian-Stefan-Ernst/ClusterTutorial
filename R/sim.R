setwd("/mnt/beegfs/home/ernst/ClusterTutorial")

id <- Sys.getenv("SLURM_PROCID")
print(id)

numbers <- runif(10)

write.csv(numbers, paste0("results/res_", id, ".csv"))
