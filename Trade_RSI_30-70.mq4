//+------------------------------------------------------------------+
//|                                              Trade_RSI_30-70.mq4 |
//|                                            Copyright 2020, Genes |
//|                                       https://www.geekyhub.co.tz |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, Genes"
#property link      "https://www.geekyhub.co.tz"
#property version   "1.0"
#property strict

int OnInit(){
   return(INIT_SUCCEEDED);
}

void OnTick(){
  if(iRSI(Symbol(),0,14,PRICE_CLOSE,0)>70) {
    if(OrdersTotal() != 0 ) {
    if(OrderType() == OP_BUYLIMIT){
      for( int i = 0; i < OrdersTotal(); i++ ){
          if(OrderSelect(i, SELECT_BY_POS)==true){ 
            int BuyOrder=OrderTicket(); 
            OrderDelete(BuyOrder,CLR_NONE);
          } else{ 
            Print("OrderSelect failed error code is",GetLastError());
          }
        }
      }
    }
   for( int i = 0; i < 30; i++ ){
      OrderSend(Symbol(),OP_SELLLIMIT,1,(Ask+58*_Point),3,0,(Bid-10*_Point),NULL,0,0,clrGreen);
   }
}

if(iRSI(Symbol(),0,14,PRICE_CLOSE,0)<30) {
  if(OrdersTotal() != 0 ) {
    if(OrderType() == OP_SELLLIMIT){
      for( int i = 0; i < OrdersTotal(); i++ ){
          if(OrderSelect(i, SELECT_BY_POS)==true){ 
            int SellOrder=OrderTicket(); 
            OrderDelete(SellOrder,CLR_NONE);
          } else{ 
            Print("OrderSelect failed error code is",GetLastError());
          }
        }
      }
    }
     for( int i = 0; i < 30; i++ ){
      OrderSend(Symbol(),OP_BUYLIMIT,1,(Bid-20*_Point),3,0,(Ask+50*_Point),NULL,0,0,clrYellow);
     }
  }
}
