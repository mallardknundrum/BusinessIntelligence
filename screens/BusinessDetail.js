import React from 'react';
import { View, Text, console, requireNativeComponent, Dimensions, StyleSheet } from 'react-native';

const ChartView = requireNativeComponent("ChartView")

export default class BusinessDetail extends React.Component {
  render() {
    const { navigation } = this.props;
    const company = navigation.getParam("otherParam", "NoCompany");
    
    const jsonString = JSON.stringify(company)

    return (
    <View style={{flex: 1, justifyContent: 'center'}}>
      <View style={styles.flexVerticalContainer}>
        <Text style={styles.title}>{company.name}</Text>
        <Text style={styles.locationText}>{company.location.city + ", " + company.location.country}</Text>
      </View>
      <ChartView 
        style={{flex: 7}}
        dataDictionaries={company}
        myNumber={2}
      />
    </View>);
  }
}

const styles = StyleSheet.create({
  flexVerticalContainer: {
    flex: 1,
    justifyContent: 'center',
    borderRadius: 45,
    borderWidth: 15,
    borderStyle: 'solid',
    borderColor: '#B5F0EA',
    flexDirection: 'column'
  },
  title: {
    fontSize: 19,
    fontWeight: 'bold',
    textAlignVertical: 'bottom',
    textAlign: 'center',
  },
  locationText: {
    fontSize: 12,
    textAlign: 'center',
  },
})