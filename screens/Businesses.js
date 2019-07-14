import React from 'react';
import { FlatList, Text, StyleSheet, View, Button } from 'react-native';
import businessData from '../data.json';
import { StackActions, NavigationActions } from 'react-navigation';



export default class Businesses extends React.Component {
  render() {
    return (
      <View style={styles.container}>
        <FlatList
          data={businessData}
          renderItem={({item})=> 
          <Button
            style={styles.item}
            onPress={() => {
              this.props.navigation.push('Profile', {
                itemId: item.id,
                otherParam: item
              });
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