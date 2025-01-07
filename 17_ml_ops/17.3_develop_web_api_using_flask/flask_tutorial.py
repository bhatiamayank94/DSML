from flask import Flask, request, jsonify
import pickle
import sklearn
 
app=Flask(__name__)

@app.route("/")
def hello_world():
    return "main page"

@app.route("/second")
def hello_again():
    return"hello again"


model=open("car_pred","rb")
mdl=pickle.load(model)
# encd = { "fuel_type": { "Petrol" :1,
#     "Diesel" :2,
#     "CNG" :3,
#     "Electric" :4 }, "tt": { "Manual" :1,
#     "Automatic" :2 }
#         }


@app.route("/req",methods=['POST'])
def price():
    input_data=request.json
    fuel_type=input_data['fuel_type']
    tt=input_data['tt']
    engine=input_data['engine']
    seats=input_data['seats']
    result=mdl.predict([[2012,1,120000,fuel_type,tt,19.7,engine,46.3,seats]])
    return jsonify(result.tolist())

if __name__ == '__main__':
       app.run(debug=True)
    
    


    

    
