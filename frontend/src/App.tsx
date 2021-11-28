import React, { useState } from "react";
import instance from "./store";
import { observer, Provider } from "mobx-react";

const App = observer(() => {
  const [backend_msg, setBackMsg] = useState("");
  const [db_msg, setDbMsg] = useState("");

  const store = instance;

  let backend_url = "http://localhost:8000/api/";

  let db_url = "http://localhost:8000/api/hello_db/";

  const handleClick = (url: string, handler: Function) => {
    let headers = { "Content-Type": "application/json" };
    return fetch(url, {
      method: "GET",
      headers: headers,
    })
      .then((response) => response.json())
      .then((data) => {
        handler(data);
      });
  };

  return (
    <Provider store>
      <div>
        <p>Hello from React default project</p>
        <button
          type="button"
          onClick={() => handleClick(backend_url, setBackMsg)}
        >
          Say hello to backend
        </button>
        <p>{backend_msg}</p>
        <button
          type="button"
          onClick={() => store.fetch(backend_url, store.setBackendMsg)}
        >
          Say hello to backend, using MobX action
        </button>
        {store.backendMsgs.map((msg: string, idx: number) => (
          <p key={`${idx}_msg`}> {msg} </p>
        ))}
        <p />
        <button type="button" onClick={() => handleClick(db_url, setDbMsg)}>
          Say hello to DB
        </button>
        <p>{db_msg}</p>
        <button
          type="button"
          onClick={() => store.fetch(db_url, store.setDbMsg)}
        >
          Say hello to db, using MobX action
        </button>
        {store.dbMsgs.map((msg: string, idx: number) => (
          <p key={`${idx}_msg`}> {msg} </p>
        ))}
      </div>
    </Provider>
  );
});

export default App;
