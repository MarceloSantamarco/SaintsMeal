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
      <div className="row">
        <div className='col-md-4'>
          <div className="form-group">
            <label>Prato</label>
            <select disabled={!request.id ? 'disabled' : ''} onChange={(e)=> setItem(e.target.value)} value={item} className="form-control">
              { allItems.map( (item) =>
                <option key={item[1]} value={item[1]}>{item[0]}</option>
              )}
            </select>
          </div>
        </div>
        <div className='col-md-4'>
          <div className="form-group">
            <label>Quantidade</label>
            <input disabled={!request.id ? 'disabled' : ''}  type="text" className='form-control' placeholder="Quantidade" onChange={e => setAmount(e.target.value)}/>
          </div>
        </div>
        <div className='col-md-4'>
          <br/>
          <div className="form-group">
            <button disabled={!request.id ? 'disabled' : ''}  className='btn btn-success' type="button" onClick={() => createAmount()}>Add Item</button>
          </div>
        </div>
      </div>
      <table className="table table-striped table-hover table-light mt-3">
        <thead>
          <tr>
            <th>Nome</th>
            <th>Quantidade</th>
            <th>Excluir</th>
          </tr>
        </thead>
        <tbody>
          {fields.map((field) => {
            return (
              <tr key={`${field.id}`} id={`${field.id}`}>
                <td>{field.item_name}</td>
                <td>{field.amount}</td>
                <td><button type='button' className='btn btn-danger' onClick={(e)=>removeAmount(e)}><i class="far fa-trash-alt"></i></button></td>
              </tr>
            );
          })}
        </tbody>
      </table>
    </div>
  );
}
