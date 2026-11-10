
library(tidyverse)

# Step 1: Import dataset
mlb <- read_csv("data/CourseProject_Math478.csv")

# -----------------------------------
# Step 2: Swing Outcome Classification
# -----------------------------------

# Binary response: 1 = Miss, 0 = Contact
mlb$miss <- ifelse(
  mlb$description %in% c("swinging_strike",
                         "swinging_strike_blocked"),
  1, 0
)

# Frequency of each outcome
print(table(mlb$miss))

# Percentage of each outcome
print(round(prop.table(table(mlb$miss)) * 100, 2))


# -----------------------------------
# Step 3: Swing-and-Miss Rate by Pitch Type
# -----------------------------------

# Calculate swing-and-miss percentage by pitch type
pitch_summary <- mlb %>%
  group_by(pitch_type) %>%
  summarise(
    pitches = n(),
    miss_rate = round(mean(miss) * 100, 2),
    .groups = "drop"
  ) %>%
  filter(!is.na(pitch_type), pitches >= 20) %>%
  arrange(desc(miss_rate))

# Display summary table
print(pitch_summary)

# Figure 1: Horizontal Bar Chart
print(
  ggplot(pitch_summary,
         aes(x = reorder(pitch_type, miss_rate),
             y = miss_rate)) +
    geom_col(fill = "steelblue") +
    coord_flip() +
    labs(
      title = "Swing-and-Miss Rate by Pitch Type",
      x = "Pitch Type",
      y = "Swing-and-Miss Rate (%)"
    ) +
    theme_minimal()
)


# -----------------------------------
# Step 4: Release Speed by Swing Outcome
# -----------------------------------

# Calculate mean and median release speed
speed_summary <- mlb %>%
  group_by(miss) %>%
  summarise(
    pitches = sum(!is.na(release_speed)),
    mean_speed = round(mean(release_speed, na.rm = TRUE), 2),
    median_speed = round(median(release_speed, na.rm = TRUE), 2),
    .groups = "drop"
  )

# Display summary table
print(speed_summary)

# Figure 2: Release Speed Boxplot
print(
  ggplot(mlb, aes(
    x = factor(miss, levels = c(0, 1),
               labels = c("Contact", "Miss")),
    y = release_speed
  )) +
    geom_boxplot(fill = "steelblue", na.rm = TRUE) +
    labs(
      title = "Release Speed by Swing Outcome",
      x = "Swing Outcome",
      y = "Release Speed (mph)"
    ) +
    theme_minimal()
)


# -----------------------------------
# Step 5: Pitch Location Heatmap
# -----------------------------------

# Calculate miss rates by location
location_summary <- mlb %>%
  filter(!is.na(plate_x), !is.na(plate_z),
         between(plate_x, -2.5, 2.5),
         between(plate_z, 0, 5)) %>%
  mutate(
    x_bin = floor(plate_x / 0.4) * 0.4 + 0.2,
    z_bin = floor(plate_z / 0.4) * 0.4 + 0.2
  ) %>%
  group_by(x_bin, z_bin) %>%
  summarise(
    pitches = n(),
    miss_rate = mean(miss),
    .groups = "drop"
  ) %>%
  filter(pitches >= 30)

# Figure 3: Pitch Location Heatmap
print(
  ggplot(location_summary,
         aes(x = x_bin, y = z_bin, fill = miss_rate)) +
    geom_tile(width = 0.4, height = 0.4) +
    scale_fill_viridis_c(
      labels = scales::label_percent(),
      limits = c(0, 1),
      name = "Miss Rate"
    ) +
    coord_fixed() +
    labs(
      title = "Swing-and-Miss Rate by Pitch Location",
      x = "Horizontal Pitch Location (ft)",
      y = "Vertical Pitch Location (ft)"
    ) +
    theme_minimal()
)


# -----------------------------------
# Step 6: Data Quality Assessment
# -----------------------------------

# Select important variables
vars <- c(
  "description", "pitch_type",
  "release_speed", "release_spin_rate",
  "pfx_x", "pfx_z",
  "plate_x", "plate_z",
  "stand", "balls", "strikes"
)

# Calculate missing values
missing_counts <- colSums(is.na(mlb[vars]))

# Create missing-value summary
missing_summary <- data.frame(
  Variable = vars,
  Missing = as.integer(missing_counts),
  Percent = round(
    100 * missing_counts / nrow(mlb), 2
  )
)

# Display missing-value summary
print(missing_summary)

# Check variable types
print(sapply(mlb[vars], class))

# Check swing outcome categories
print(table(mlb$description, useNA = "ifany"))

# Check dates included in dataset
print(range(mlb$game_date, na.rm = TRUE))


# -----------------------------------
# Step 7: Final Data Quality Checks
# -----------------------------------

# Verify the actual date range
print(range(mlb$game_date, na.rm = TRUE))

# Check for duplicate pitches
duplicate_count <- sum(duplicated(
  mlb[c("game_pk", "at_bat_number", "pitch_number")]
))
print(duplicate_count)

# Count observations with complete predictor data
complete_count <- sum(complete.cases(mlb[vars]))
print(complete_count)

# Examine release-speed distribution
print(summary(mlb$release_speed))

