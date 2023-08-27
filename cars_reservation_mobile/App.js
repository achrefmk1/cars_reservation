import React from "react";
import { NavigationContainer } from "@react-navigation/native";
import { createStackNavigator } from "@react-navigation/stack";
import LoginScreen from "./src/screens/LoginScreen";
import HomeScreen from "./src/screens/HomeScreen";
import AgenciesScreen from "./src/screens/AgenciesScreen";
import UsersScreen from "./src/screens/UsersScreen";
import EditUserScreen from "./src/screens/EditUserScreen";
import RegisterScreen from "./src/screens/RegisterScreen";
import AddUserScreen from "./src/screens/AddUserScreen";
import CarsManagementCRUDScreen from "./src/screens/cars/CarsManagement";
import AgenciesManagementCRUDScreen from "./src/screens/agencies/AgenciesManagementCRUDScreen";
import AgencyListScreen from "./src/screens/agencies/AgencyListScreen";
import AgencyDetailsScreen from "./src/screens/agencies/AgencyDetailsScreen";
import RDVScreen from "./src/screens/agencies/RDVScreen";
import DaysOffScreen from "./src/screens/agencies/DayOffsScreen";
import AgencyServicesScreen from "./src/screens/agencies/AgencyServicesScreen";
import CarHistoryScreen from "./src/screens/cars/CarHistoryScreen";
import AgencyHistoryScreen from "./src/screens/agencies/AgencyHistoryScreen";
import WelcomeScreen from "./src/screens/WelcomeScreen";

const Stack = createStackNavigator();

const App = () => {
  return (
      <NavigationContainer>
          <Stack.Navigator initialRouteName="CarBook">
              <Stack.Screen name="CarBook" component={WelcomeScreen} />
              <Stack.Screen name="Se Connecter" component={LoginScreen} />
              <Stack.Screen name="Inscription" component={RegisterScreen} />
              <Stack.Screen name="Accueil" component={HomeScreen} />
              <Stack.Screen
                  name="Mes Agences"
                  component={AgenciesManagementCRUDScreen}
              />
              <Stack.Screen name="Utilisateurs" component={UsersScreen} />
              <Stack.Screen name="Modifier" component={EditUserScreen} />
              <Stack.Screen
                  name="Nouveau Utilisateur"
                  component={AddUserScreen}
              />
              <Stack.Screen
                  name="Mes Voitures"
                  component={CarsManagementCRUDScreen}
              />
              <Stack.Screen name="Résultats" component={AgencyListScreen} />
              <Stack.Screen name="Détails" component={AgencyDetailsScreen} />
              <Stack.Screen name="RDV" component={RDVScreen} />
              <Stack.Screen name="Jours Fériés" component={DaysOffScreen} />
              <Stack.Screen
                  name="Mes Services"
                  component={AgencyServicesScreen}
              />
              <Stack.Screen name="Historique" component={CarHistoryScreen} />
              <Stack.Screen
                  name="Mes Rendez-vous"
                  component={AgencyHistoryScreen}
              />
          </Stack.Navigator>
      </NavigationContainer>
  );
};

export default App;
