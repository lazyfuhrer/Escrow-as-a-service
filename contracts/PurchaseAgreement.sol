// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;
contract PurchaseAgreement{

     address payable public seller;
     address payable public buyer;
     uint public value;
     enum State{Created,Locked,Release,Inactive}
     State public  state;
     constructor() payable{
        seller=payable(msg.sender);
        value=msg.value/2;
        state=State.Created;
     }

     ///Not Suffient Amount. Pay 2X times
     error LessAmount();

     ///not a valid state
     error invalidState( );

     ///only Buyer can call this function
     error onlyBuyer( );
    ///only Seller can call this function
     error onlyseller();


     modifier inState(State _state){
        if(state!=_state) { revert invalidState(); }
        _;
     }

     modifier OnlyBuyer(){
        if (msg.sender!=buyer) { revert onlyBuyer(); }
        _;
     }
     modifier OnlySeller(){
        if(msg.sender!=seller) { revert onlyseller(); }
        _;
     }

     function ConfirmPurchase() external payable inState(State.Created) {
        buyer=payable(msg.sender);
        if(msg.value<value*2){
            revert LessAmount();
        }
        state=State.Locked;
     }

     function Contract_Balance() public view returns(uint)  {
        return address(this).balance;
     }
   
    function confirmRecieved() external  OnlyBuyer inState(State.Locked){
        state=State.Release;
        buyer.transfer(value);
    }

    function paySeller() external OnlySeller inState(State.Release){
        state=State.Inactive;
        seller.transfer(Contract_Balance());
    }

    function abort() external OnlySeller inState(State.Created){
        state=State.Inactive;
        seller.transfer(Contract_Balance());
    }
}