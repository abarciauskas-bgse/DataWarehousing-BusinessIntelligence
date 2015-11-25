/**
DATASET: DB with historical transactions of a sport fashion retailer

 - Sales history is stored in table SALES_HISTORY
   Information at product-size level (for clothing which has sizes) 
   QTY in units, NET_SALES in €

 - Product definition in PRODUCTS
   Products have an associated SECTION

 - List of branches in BRANCH
   STORE_METREAGE is informed in m2

 - Changes in stock are recorded in trable STOCKCHANGES
   This is, every time a transaction occurs, a new row
   is added to STOCKCHANGES. Days without sales are not recorded
   (for simplicity, only one branch recorded)

**/


/** QUESTIONS:
	
	QUESTION 1: Select top 10 branches by sales volume (€) in 2013
  QUESTION 2: Select top 10 sections by sales volume in € and units in 2013
	QUESTION 3: Select top 10 brances by sales / m2 in 2013
	QUESTION 4: Compute stock on Dec. 31st 2013.
	QUESTION 5: Compute square meters by section.
	QUESTION 6: Compute top 10 sections by sales density (€/m2).
    
**/


/** CODE: **/


/**
 *  QUESTION 1: Select top 10 branches by sales volume (€) in 2013
 */

-- All sales are in 2013 but we have a where just in case
select sum(net_sales) from z_sales_history
  where DATE(sales_date) BETWEEN '2013-01-01' AND '2014-01-01'
  group by branch_no;

/**
    QUESTION 2: Select top 10 sections by sales volume in € and units in 2013
**/




/**
    QUESTION 3: Select top 10 brances by sales / m2 in 2013
**/




/**
   QUESTION 4: Compute stock on Dec. 31st 2013 in branch 969. How many units does it have?
   Remember table STOCKCHANGES only records stock movements.

**/


/**
    QUESTION 5: Compute number of square meters occupied by every section at branch '969'
				on Dec. 31st 2013.
 	ASSUMPTION: Every reference occupies the same space at the store (a reference is a
				unique product code without taking sizes into account).
**/
