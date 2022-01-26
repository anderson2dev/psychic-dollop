async function handler(event, context) {
    console.log(context, event);
    return {
        greetingMessage: 'Hi fella',
    };
}

module.exports =  {
    handler,
}