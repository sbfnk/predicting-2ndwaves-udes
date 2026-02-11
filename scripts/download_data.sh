#!/bin/bash
# Downloads the raw data files required by get_data.jl
# Sources:
#   - Google COVID-19 Community Mobility Reports (archived, last updated 2022-10-15)
#   - JHU CSSE COVID-19 time series (archived, last updated 2023-03-10)
#   - Oxford COVID-19 Government Response Tracker (OxCGRT) stringency index

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DATA_DIR="$SCRIPT_DIR/../data/exp_raw"

mkdir -p "$DATA_DIR"

echo "Downloading Google Mobility Reports..."
for cc in CA US NL AT DE BE IT KR; do
    echo "  $cc"
    curl -sL -o "$DATA_DIR/2020_${cc}_Region_Mobility_Report.csv" \
        "https://www.gstatic.com/covid19/mobility/2020_${cc}_Region_Mobility_Report.csv"
done
# Google uses GB for the United Kingdom, but the script expects UK
echo "  GB -> UK"
curl -sL -o "$DATA_DIR/2020_UK_Region_Mobility_Report.csv" \
    "https://www.gstatic.com/covid19/mobility/2020_GB_Region_Mobility_Report.csv"

echo "Downloading JHU CSSE time series..."
curl -sL -o "$DATA_DIR/time_series_covid19_confirmed_US.csv" \
    "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_US.csv"
curl -sL -o "$DATA_DIR/time_series_covid19_confirmed_global.csv" \
    "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv"

echo "Downloading Oxford Stringency Index..."
curl -sL -o "$DATA_DIR/strin_index.csv" \
    "https://raw.githubusercontent.com/OxCGRT/covid-policy-tracker/master/data/timeseries/stringency_index_avg.csv"

echo "Done. Files saved to $DATA_DIR"
