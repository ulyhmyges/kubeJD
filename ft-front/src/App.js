import React from 'react';
import logo from './logo.svg';
import './App.css';
import Navbar from './Navbar';
import CardGrid from "./CardGrid";



function App() {
    return (
        <div className="App">
            <header className="App-header">
                <Navbar />
                <CardGrid />
            </header>
        </div>
    );
}

export default App;

