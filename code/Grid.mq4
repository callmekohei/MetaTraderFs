#property strict
#property indicator_chart_window
extern int GridSpace=100;

#import "library5.dll"

   void SetGridValue (
      int    &arr[],
      int    size,
      double highValue,
      double lowValue,
      double point,
      int    gridspace,
      double &array[]
   );

   int GridNumber (
      int    &arr[],
      int    size,
      double highValue,
      double lowValue,
      double point,
      int    gridspace
   );

#import

int OnInit()
   {
      return(INIT_SUCCEEDED);
   }

void OnDeinit(const int reason)
   {
      deleteGrid ();
   }

int OnCalculate(const int        rates_total,
                const int        prev_calculated,
                const datetime   &time[],
                const double     &open[],
                const double     &high[],
                const double     &low[],
                const double     &close[],
                const long       &tick_volume[],
                const long       &volume[],
                const int        &spread[])
  {
      createGrid ();
      return(rates_total);
  }


void createGrid ()
   {

      int HighNumber = Highest(NULL,0,MODE_HIGH, Bars, 0) ;
      int LowNumber  = Lowest (NULL,0,MODE_LOW,  Bars, 0) ;

      double HighPrice = High[HighNumber];
      double LowPrice  = Low [LowNumber ];

      int dammyArray[1];

      int num = GridNumber(dammyArray,1,HighPrice,LowPrice,Point,GridSpace);

      double arr[];
      ArrayResize(arr,num);
      for(int j=0;j<num;j++){
            arr[j] = 0;
      }

      SetGridValue(dammyArray, num, HighPrice, LowPrice,Point, GridSpace, arr) ;

      for(int i=0;i<ArraySize(arr);i++){
         if(arr[i] != 0){
            if (ObjectFind("Grid"+i) != 0){
                  ObjectCreate( "Grid" + i, OBJ_HLINE, 0, Time[1], arr[i]);
                  ObjectSet   ( "Grid" + i, OBJPROP_STYLE, 2 );
                  ObjectSet   ( "Grid" + i, OBJPROP_COLOR, DarkGreen);
            }
         }
      }
   }

 void deleteGrid ()
   {
      int HighNumber = Highest(NULL,0,MODE_HIGH, Bars, 0) ;
      int LowNumber  = Lowest (NULL,0,MODE_LOW,  Bars, 0) ;

      double HighPrice = High[HighNumber];
      double LowPrice  = Low [LowNumber ];

      int dammyArray[1];
      int num = GridNumber(dammyArray,1,HighPrice,LowPrice,Point,GridSpace);

      double arr[];
      ArrayResize(arr,num);
      for(int j=0;j<num;j++){
            arr[j] = 0;
      }

      SetGridValue(dammyArray, num, HighPrice, LowPrice,Point, GridSpace, arr) ;

      for(int i=0;i<ArraySize(arr);i++){
         if(arr[i] != 0){
            ObjectDelete("Grid" + i);
         }
      }


   }
