import pandas as pd
import numpy as np
from sklearn.linear_model import LogisticRegression
from sklearn.model_selection import train_test_split

train = pd.read_csv('../input/titanic_data.csv');
corrmat = train.corr();

train.info();

def normalize(inputData):
    temp = inputData.fillna(value = inputData.mean())
    mu = inputData.mean()
    sigma = inputData.std()
    return (temp - mu) / sigma

def denormalize(inputData, mu, sigma):
    return (inputData * sigma) + mu

def sigmoid(z):
    return  1.0 / ( 1 + np.exp(-z))


train.Sex = train.Sex.astype('category')
train.Embarked = train.Embarked.fillna(value = 'S')
train.Embarked = train.Embarked.astype('category')
train = train.drop(['Name','Ticket','Cabin'],axis=1)
train.set_index('PassengerId');
train.info()
mean_age = train.Age.mean()
train.Age = train.Age.fillna(mean_age)
train.Age = normalize(train.Age)
train.Fare = normalize(train.Fare)
cols_to_transform = [ 'Sex','Embarked' ]
train = pd.get_dummies(train, columns = cols_to_transform )

y = train['Survived']
X = train[['Pclass', 'Age','SibSp','Parch','Fare','Sex_female','Sex_male','Embarked_C','Embarked_Q','Embarked_S']]

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.33, random_state=21)

logit = LogisticRegression(max_iter=400)
logit.fit(X_train,y_train)

pred = logit.predict(X_test)
print("accuracy %f"%(float(sum(abs(y_test-pred == 0)))/len(pred)))