//helpers/state.js
export function client(app){
    const service = {
        getClient(){
            return this.client;
        },
        setClient(client){
            this.client = client;
        },
        client: null,
    };
    app.setService("client", service);
}