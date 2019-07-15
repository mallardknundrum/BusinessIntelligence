import React from 'react';
import { FlatList, Text, StyleSheet, View, Button, TouchableOpacity } from 'react-native';
import businessData from '../data.json';
import { StackActions, NavigationActions } from 'react-navigation';



export default class Businesses extends React.Component {

  // constructor (props) {
  //   super(props);
  //   this.state = {
  //     dataSource: [],
  //   }
  // }
  // componentDidMount() {
  //   console.log(businessData)
  //   this.setState({dataSource: businessData})  
  // }
  render() {
    return (
      <View style={styles.container}>
        <FlatList
          data={businessData}
          renderItem={({item})=> 
          <TouchableOpacity
            style={styles.item}
            onPress={() => {
              this.props.navigation.push('Profile', {
                itemId: item.id,
                otherParam: item
              });
            }}
          >
            <Text>{item.name}</Text>
          </TouchableOpacity>
          }
          keyExtractor={(item, index) => index.toString()}
        />
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
   flex: 1,
   paddingTop: 22
  },
  item: {
    padding: 10,
    fontSize: 18,
    height: 44
  },
})