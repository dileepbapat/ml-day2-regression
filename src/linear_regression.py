import pandas as pd
import numpy as np
from sklearn.linear_model import LinearRegression
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import Normalizer

data = pd.read_csv('../input/house_data.csv');
corrmat = data.corr();
data.info();
y = data['SalePrice']
X = data.drop(['SalePrice'], axis=1)

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.1, random_state=21)

model = LinearRegression()
features = ['OverallQual', 'GrLivArea']
model.fit(X_train[features], y_train)
pred = model.predict(X_test[features])

print (sum((pred - y_test)**2))


features = ['OverallQual', 'GrLivArea', 'GarageCars', 'GarageArea', 'TotalBsmtSF', 'FullBath','TotRmsAbvGrd', 'YearBuilt', 'YearRemodAdd' ]
model.fit(X_train[features], y_train)
pred = model.predict(X_test[features])

print (sum((pred - y_test)**2))



