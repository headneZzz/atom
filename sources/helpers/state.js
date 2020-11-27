//helpers/state.js
export function state(app){
    const service = {
        getClient(){
            return this.client;
        },
        getClientId(){
            if (this.client) return this.client.client_id; else return null;
        },
        setClient(client){
            this.client = client;
        },
        client: null,

        getUnit(){
            return this.unit;
        },
        setUnit(unit){
            this.unit = unit;
        },
        unit: null
    };
    app.setService("state", service);
}