/* 
========================================================================================
Stored Procedure: Load Bronze Layer(Source-> Bronze) 
========================================================================================
Script Purpose:
   This stored procedure loads data into the 'bronze' schema from external CSV files.
   It Performs the following actions:
   -Truncate the bronze tables before loading data.
   -Uses the BULK INSERT command  to load data from csv files to bronze tables.
Parameters:
    None.
  This stored procedure does not accept any parameters or return any values.
Usage Example:
    EXEC broze.load_bronze;
=========================================================================================
*/


CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN 
	  DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME; 
	   BEGIN TRY
	   SET @batch_start_time =GETDATE();
		PRINT '=================================================';
		PRINT 'Loading Bronze Layer';
		PRINT '==================================================';


		PRINT'---------------------------------------------------';
		PRINT' Loading CRM Table';
		PRINT'---------------------------------------------------';

		PRINT '>>Truncating Table: bronze.crm_cust_info';	
			TRUNCATE TABLE bronze.crm_cust_info;
		SET @start_time = GETDATE();
		PRINT '>>Inserting Data Into: bronze.crm_cust_info';
			BULK INSERT bronze.crm_cust_info
			FROM 'C:\Users\Gokul\Downloads\cust_info.csv'
			WITH (
			FIRSTROW= 2,
			FIELDTERMINATOR = ',',
			TABLOCK
			);
		SET @end_time= GETDATE();
		PRINT'>>Load Duration:' + CAST(DATEDIFF(second, @start_time,@end_time) AS NVARCHAR)+ 'Seconds';
		PRINT'------------------------------------------';

		PRINT '>>Truncating Table: bronze.crm_prd_info';

			TRUNCATE TABLE bronze.crm_prd_info;

		 SET @start_time= GETDATE();
		PRINT '>>Inserting Data Into: bronze.crm_prd_info';

			BULK INSERT bronze.crm_prd_info
			FROM 'C:\Users\Gokul\Downloads\prd_info.csv'
			WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR= ',',
			TABLOCK
			);
		 SET @end_time= GETDATE();
		 PRINT'>>Load Duration:'+ CAST(DATEDIFF(second,@start_time, @end_time) AS NVARCHAR) +'Seconds';
		 PRINT'-------------------------------------------------';


		PRINT '>>Truncating Table: bronze.crm_sales_details';	
			TRUNCATE TABLE bronze.crm_sales_details;

		SET @start_time= GETDATE();
		PRINT '>>Inserting Data Into: bronze.crm_sales_details';
			BULK INSERT bronze.crm_sales_details
			FROM 'C:\Users\Gokul\Downloads\sales_details.csv'
			WITH(
			FIRSTROW= 2,
			FIELDTERMINATOR =',',
			TABLOCK
			);
		SET @end_time= GETDATE();
		PRINT' >>Load Duration:' +CAST(DATEDIFF(second,@start_time, @end_time) AS NVARCHAR) +'seconds';
		PRINT'----------------------------------------------------';

		PRINT'---------------------------------------------------';
		PRINT' Loading ERP Table';
		PRINT'---------------------------------------------------';

		PRINT '>>Truncating Table: bronze.erp_CUST_AZ12';
			 TRUNCATE TABLE bronze.erp_CUST_AZ12;
		 SET @start_time= GETDATE();
		PRINT '>>Inserting Data Into: bronze.erp_CUST_AZ12';
			BULK INSERT bronze.erp_CUST_AZ12
			FROM 'C:\Users\Gokul\Downloads\CUST_AZ12.csv'
			WITH(
			FIRSTROW= 2,
			FIELDTERMINATOR = ',',
			TABLOCK
			);
			SET @end_time= GETDATE();
			PRINT'>>Load Duration:' +CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) +'seconds';

		PRINT '>>Truncating Table: bronze.erp_LOC_A101';
			TRUNCATE TABLE bronze.erp_LOC_A101;

		SET @start_time= GETDATE();
		PRINT '>>Inserting Data Into: bronze.erp_LOC_A101';
			BULK INSERT bronze.erp_LOC_A101
			FROM 'C:\Users\Gokul\Downloads\LOC_A101.csv'
			WITH(
			FIRSTROW= 2,
			FIELDTERMINATOR = ',',
			TABLOCK
			);
	SET @end_time= GETDATE();
	PRINT'>> Load Duration:' +CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) +'Seconds';
	PRINT'------------------------------------------------------------------'

	
		PRINT '>>Truncating Table: bronze.erp_CAT_G1V2';	
		   TRUNCATE TABLE bronze.erp_PX_CAT_G1V2;
		SET @start_time =GETDATE();

		PRINT '>>Inserting Data Into: bronze.erp_CAT_G1V2';
			BULK INSERT bronze.erp_PX_CAT_G1V2
			FROM 'C:\Users\Gokul\Downloads\PX_CAT_G1V2.csv'
			WITH(
			FIRSTROW= 2,
			FIELDTERMINATOR= ',',
			TABLOCK
			);
		SET @end_time=GETDATE();
		PRINT'>>Load Duration:'+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+ 'Seconds';
		PRINT'--------------------------------------------------------------------';

		SET @batch_end_time= GETDATE();
		PRINT'======================================================================';
		PRINT'Loading Bronze Layer is Completed';
		PRINT' -Total Load Duration:'+ CAST(DATEDIFF(Second,@batch_start_time, @batch_end_time) AS NVARCHAR)+'Seconds';
		PRINT'======================================================================';
	END TRY
	BEGIN CATCH
	PRINT '================================================================'
	PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER';
	PRINT 'Error Message'+ ERROR_MESSAGE();
	PRINT 'Error Message'+ CAST(ERROR_NUMBER() AS NVARCHAR);
	PRINT 'Error Message'+ CAST(ERROR_STATE() AS NVARCHAR);
	PRINT '================================================================'
	END CATCH 
	END

