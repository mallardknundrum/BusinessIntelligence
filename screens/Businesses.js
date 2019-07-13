import React from 'react';
import { FlatList, Text, StyleSheet, View, Button, Alert } from 'react-native';
import businessData from '../data.json';



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
          <Button
            style={styles.item}
            onPress={() => {
              Alert.alert("I was pressed");
            }}
            title={"Company Name: " + item.name}
          />
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