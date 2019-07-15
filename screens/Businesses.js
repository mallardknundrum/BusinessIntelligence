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
            <View style={styles.cellView}>
             <Text style={styles.cellText}>{item.name}</Text>
            </View>
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
   paddingTop: 22,
  //  backgroundColor: '#6857B2',
  },
  item: {
    padding: 1,
    height: 44,
  },
  cellView: {
    justifyContent: 'center',
    borderRadius: 45,
    borderWidth: 5,
    borderStyle: 'solid',
    backgroundColor: '#6857B2',
    borderColor: '#B5F0EA',
  },
  cellText: {
    textAlign: 'center',
    fontWeight: 'bold',
    fontSize: 25,
    color: '#FFFFFF',
  }
})