import React from 'react';
import './CardGrid.css';

const placeholderCards = [
    { id: 1, title: 'Event 1', description: 'This is a description for Event 1.', imageUrl: `${process.env.PUBLIC_URL}/event1.png` },
    { id: 2, title: 'Event 2', description: 'This is a description for Event 2.', imageUrl: `${process.env.PUBLIC_URL}/event2.png` },
    { id: 3, title: 'Event 3', description: 'This is a description for Event 3.', imageUrl: `${process.env.PUBLIC_URL}/event3.png` },
    // ... add more placeholders as needed
];


const CardGrid = () => {
    return (
        <div className="card-grid-container">
            <h2>POPULAR EVENTS</h2>
            <div className="card-grid">
                {placeholderCards.map((card) => (
                    <div key={card.id} className="card">
                        <img src={card.imageUrl} alt={card.title} />
                        <div className="card-info">
                            <h3>{card.title}</h3>
                            <p>{card.description}</p>
                        </div>
                    </div>
                ))}
            </div>
        </div>
    );
};

export default CardGrid;
