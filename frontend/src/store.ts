import { action, autorun, computed, makeObservable, observable } from "mobx";
import { autoAction } from "mobx/dist/api/action";

class TestStore {
  backendMsgs: string[] = [];
  dbMsgs: string[] = [];

  constructor() {
    makeObservable(this, {
      backendMsgs: observable,
      dbMsgs: observable,
      storeDetails: computed,
      fetch: action.bound,
      setBackendMsg: action.bound,
      setDbMsg: action.bound,
    });
    autorun(this.logStoreDetails);
  }

  get storeDetails() {
    return `We have ${this.backendMsgs.length} msgs from backend and ${this.dbMsgs.length} msgs from db, so far!!!`;
  }

  logStoreDetails = () => {
    console.log(this.storeDetails);
  };

  fetch(url: string, handler: Function) {
    let headers = { "Content-Type": "application/json" };
    return fetch(url, {
      method: "GET",
      headers: headers,
    })
      .then((response) => response.json())
      .then((data) => {
        handler(data);
      });
  }

  setBackendMsg(msg: string) {
    this.backendMsgs.push(msg);
  }

  setDbMsg(msg: string) {
    this.dbMsgs.push(msg);
  }
}

const instance = new TestStore();

export default instance;
