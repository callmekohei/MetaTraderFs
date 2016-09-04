#property strict
#property indicator_chart_window
#property indicator_buffers 5
#property indicator_color1 Aqua
#property indicator_color2 Yellow
#property indicator_color3 Red
#property indicator_color4 Sienna
#property indicator_color5 Sienna

double ema10Buffer[];
double sma13Buffer[];
double ema25Buffer[];
double ExtUpperBuffer[];
double ExtLowerBuffer[];

#import "library5.dll"

   void BandsCustomed (
      double &array[],
      int    arraySize,
      int    prev,
      double &ema10Buf[],
      double &sma13Buf[],
      double &ema25Buf[],
      double &upperBuf[],
      double &lowerBuf[] );

#import


int OnInit(void)
  {

   IndicatorBuffers (5);
   IndicatorDigits  (Digits);

   SetIndexStyle  (0,DRAW_LINE);
   SetIndexBuffer (0,ema10Buffer);
   SetIndexStyle  (1,DRAW_LINE);
   SetIndexBuffer (1,sma13Buffer);
   SetIndexStyle  (2,DRAW_LINE);
   SetIndexBuffer (2,ema25Buffer);
   SetIndexStyle  (3,DRAW_LINE);
   SetIndexBuffer (3,ExtUpperBuffer);
   SetIndexStyle  (4,DRAW_LINE);
   SetIndexBuffer (4,ExtLowerBuffer);

   return(INIT_SUCCEEDED);
  }


int OnCalculate(const int      rates_total,
                const int      prev_calculated,
                const datetime &time[],
                const double   &open[],
                const double   &high[],
                const double   &low[],
                const double   &close[],
                const long     &tick_volume[],
                const long     &volume[],
                const int      &spread[])
  {

   //--- counting from 0 to rates_total
   ArraySetAsSeries(ema10Buffer   ,false);
   ArraySetAsSeries(sma13Buffer   ,false);
   ArraySetAsSeries(ema25Buffer   ,false);
   ArraySetAsSeries(ExtUpperBuffer,false);
   ArraySetAsSeries(ExtLowerBuffer,false);
   ArraySetAsSeries(close,         false);

   //--- initial zero
   int i;
   if(prev_calculated<1)
     {
      for(i=0; i<10; i++)
        {
         ema10Buffer[i] = EMPTY_VALUE;
        }

      for(i=0; i<13; i++)
        {
         sma13Buffer[i] = EMPTY_VALUE;
        }

      for(i=0; i<25; i++)
        {
         ema25Buffer[i]    = EMPTY_VALUE;
         ExtUpperBuffer[i] = EMPTY_VALUE;
         ExtLowerBuffer[i] = EMPTY_VALUE;
        }
     }

   // clone array of close prices
   double myClose[];
   ArraySetAsSeries ( myClose, false);
   ArrayResize ( myClose, Bars );

   for(int j=0;j<Bars;j++)
     {
         myClose[j] = close[j];
     }

   // DLL function
   BandsCustomed(
      myClose,
      ArraySize(myClose),
      prev_calculated,
      ema10Buffer,
      sma13Buffer,
      ema25Buffer,
      ExtUpperBuffer,
      ExtLowerBuffer );

   return(rates_total);
  }

