import pandas
import coremltools
from sklearn.linear_model import LinearRegression

rawdata = pandas.read_csv("cars.csv")

model = LinearRegression()
model.fit(rawdata[["modelo", "extras", "kilometraje", "estado"]], rawdata["precio"])

coreml_model = coremltools.converters.sklearn.convert(model, ["modelo", "extras", "kilometraje", "estado"], "price")

coreml_model.author = "Eduardo De La Cruz"
coreml_model.license = "CC0"
coreml_model.short_description = "Este modelo predice el valor de venta de un coche segun diversos parametros."

coreml_model.save("Cars.mlmodel")