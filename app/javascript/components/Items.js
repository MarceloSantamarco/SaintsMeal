import React, {useState, useEffect} from "react"
import axios from  'axios'

export default function Items({allItems, request}) {

  let [fields, setFields] = useState([]);
  let [amount, setAmount] = useState({})
  let [item, setItem] = useState(allItems[0][1])

  useEffect(()=>{
    getAmounts();
  }, [])

  function getAmounts() {
    if (request.id){
      axios.get(`http://localhost:3000/requests/${request.id}/amounts/all`).then(response =>{
        let value = [];
        response.data.map((dt)=>{
          value.push({id: dt[0], item_id: dt[1], amount: dt[2], item_name: dt[3]});
        })
        setFields(value);
      })
    }
  }

  function createAmount() {
    let amounts = {item_id: item, amount: amount};
    axios.patch(`http://localhost:3000/requests/${request.id}/amounts`, {amounts}).then(() => {
      getAmounts();
    })
  }

  function removeAmount(e) {
    let amount = (e.target.parentNode).parentNode.id;
    axios.delete(`http://localhost:3000/requests/${request.id}/amounts/${amount}/delete`).then(() =>{
      getAmounts();
    })
  }

  return (
    <div>
      <div>
        <select disabled={!request.id ? 'disabled' : ''} onChange={(e)=> setItem(e.target.value)} value={item}>
          { allItems.map( (item) =>
            <option key={item[1]} value={item[1]}>{item[0]}</option>
          )}
        </select>
        <input disabled={!request.id ? 'disabled' : ''}  type="text" placeholder="Quantidade" onChange={e => setAmount(e.target.value)}/>
        <button disabled={!request.id ? 'disabled' : ''}  className='btn' type="button" onClick={() => createAmount()}>Add Item</button>
      </div>
      <table>
        <thead>
          <tr>
            <th>Nome</th>
            <th>Quantidade</th>
          </tr>
        </thead>
        <tbody>
          {fields.map((field) => {
            return (
              <tr key={`${field.id}`} id={`${field.id}`}>
                <td>{field.item_name}</td>
                <td>{field.amount}</td>
                <td><button type='button' onClick={(e)=>removeAmount(e)}>X</button></td>
              </tr>
            );
          })}
        </tbody>
      </table>
    </div>
  );
}
