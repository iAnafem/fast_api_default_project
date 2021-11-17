import React, { useState } from "react";

function App() {
  const [backend_msg, setBackMsg] = useState("");
  const [db_msg, setDbMsg] = useState("");

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
    <div>
      <p>Hello from React default project</p>
      <button
        type="button"
        onClick={() => handleClick(backend_url, setBackMsg)}
      >
        Say hello to backend
      </button>
      <p>{backend_msg}</p>
      <button type="button" onClick={() => handleClick(db_url, setDbMsg)}>
        Say hello to DB
      </button>
      <p>{db_msg}</p>
    </div>
  );
}

export default App;
