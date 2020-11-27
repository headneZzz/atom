//helpers/state.js
export function unit(app){
    const service = {
        getUnit(){
            return this.unit;
        },
        setUnit(unit){
            this.unit = unit;
        },
        unit: null,
    };
    app.setService("unit", service);
}