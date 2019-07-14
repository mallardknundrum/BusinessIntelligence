import React from 'react';
import { View, Text, console } from 'react-native';

export default class BusinessDetail extends React.Component {
  render() {
    const { navigation } = this.props;
    const company = navigation.getParam("otherParam", "NoCompany");
    // console.log({JSON.stringify(company)});

    return (
    <View style={{flex: 1, justifyContent: 'center'}}>
      <Text style={{fontSize: 45}}>{JSON.stringify(company)}</Text>
    </View>);
  }
}

// import React from 'react';
// import { 
//   View, 
//   Text, 
//   console, 
//   requireNativeComponent, 
// } from 'react-native';

// const CounterView = requireNativeComponent("ChartsView")


// export default class BusinessDetail extends React.Component {
//   render() {
//     const { navigation } = this.props;
//     const company = navigation.getParam("otherParam", "NoCompany");
//     // console.log({JSON.stringify(company)});

//     return (
//     <View style={{flex: 1, justifyContent: 'center'}}>
//       <View style={{flex: 1}}>
//         <Text style={{fontSize: 15, flex: 1}}>{JSON.stringify(company)}</Text>
//       </View>
//       <CounterView style={{flex: 3}}/>
//     </View>);
//   }
// }