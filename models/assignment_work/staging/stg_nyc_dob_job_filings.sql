WITH source AS (

    SELECT *
    FROM {{ source('raw', 'source_nyc_dob_job_apps') }}

),

cleaned AS (

    SELECT
        job_filing_number,
        filing_status,
        job_type,

        filing_date,

        house_no,
        street_name,
        borough,
        COALESCE(zip, postcode) AS zip,

        bbl,
        bin,
        council_district,

        SAFE_CAST(latitude AS FLOAT64) AS latitude,
        SAFE_CAST(longitude AS FLOAT64) AS longitude,

        SAFE_CAST(current_status_date AS TIMESTAMP) AS current_status_date,
        SAFE_CAST(approved_date AS TIMESTAMP) AS approved_date,
        SAFE_CAST(first_permit_date AS TIMESTAMP) AS first_permit_date,
        SAFE_CAST(signoff_date AS TIMESTAMP) AS signoff_date,

        filing_representative_first_name,
        filing_representative_middle_initial,
        filing_representative_last_name,
        filing_representative_business_name,
        filing_representative_street_name,
        filing_representative_city,
        filing_representative_state,
        filing_representative_zip

    FROM source

    WHERE job_filing_number IS NOT NULL

)

SELECT *
FROM cleaned