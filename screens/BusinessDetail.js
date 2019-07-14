import React from 'react';
import { View, Text, console, requireNativeComponent } from 'react-native';

const ChartView = requireNativeComponent("ChartView")

export default class BusinessDetail extends React.Component {
  render() {
    const { navigation } = this.props;
    const company = navigation.getParam("otherParam", "NoCompany");
    // console.log({JSON.stringify(company)});

    return (
    <View style={{flex: 1, justifyContent: 'center'}}>
      <View style={{flex: 1}}>
        <Text style={{fontSize: 10}}>{JSON.stringify(company)}</Text>
      </View>
      <ChartView style={{flex: 3}}/>
    </View>);
  }
}