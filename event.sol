pragma solidity >= 0.5.0 <0.9.0;

contract eventorg
{

    struct Event{
        string name;
        address organizers;
        uint date;
        uint price;
        uint ticketremain;
         uint ticketcount;

    }
    mapping(uint=>Event)public events;
    mapping(address=>mapping(uint=>uint)) public tickets;
    uint public nextid;

    function createvent(string memory name,uint date,uint price,uint ticketcount) public{
        require(date > block.timestamp ,"cant create vent noe" );
        require(ticketcount > 0 ,"ticketcount cant be empty");
      
        events[nextid] = Event(name, msg.sender, date, price, ticketcount, ticketcount);

        nextid++;


    }
    function buytickets(uint id,uint quantity ) external payable
    {   require(events[id].date!=0);
        require(events[id].date>block.timestamp,"event over");
        Event storage _event=  events[id];
        require(msg.value > _event.price *quantity,"not enough ether");
        require(_event.ticketremain > quantity ,"not enough ticket");
        _event.ticketremain-=quantity;  
        tickets[msg.sender][id]+=quantity;
    }
    function transfer(uint id,uint quantity,address to) external{
        require(events[id].date!=0,"no event");
        require(events[id].date>block.timestamp,"event over");
        require(tickets[msg.sender][id] > quantity,"not enogh ticlers ticets");
        tickets[msg.sender][id] -=quantity ;
        tickets[to][id]+=quantity;
    }
    
}
